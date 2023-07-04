import argparse
import requests
import io

from oauth2client.service_account import ServiceAccountCredentials
import json

import os

PROJECT_ID = os.getenv("PROJECT_ID")
CREDENTIALS = json.loads(os.getenv("FIREBASE_CREDENTIALS"))

BASE_URL = "https://firebaseremoteconfig.googleapis.com"
REMOTE_CONFIG_ENDPOINT = "v1/projects/" + PROJECT_ID + "/remoteConfig"
REMOTE_CONFIG_URL = BASE_URL + "/" + REMOTE_CONFIG_ENDPOINT
SCOPES = ["https://www.googleapis.com/auth/firebase.remoteconfig"]

# [START retrieve_access_token]
def _get_access_token():
    credentials = ServiceAccountCredentials.from_json_keyfile_dict(CREDENTIALS, SCOPES)
    access_token_info = credentials.get_access_token()
    return access_token_info.access_token
# [END retrieve_access_token]


def _get(save=False):
    headers = {"Authorization": "Bearer " + _get_access_token()}
    resp = requests.get(REMOTE_CONFIG_URL, headers=headers)

    if save != False and resp.status_code == 200:
        with io.open("config.json", "wb") as f:
            f.write(resp.text.encode("utf-8"))

        print("Retrieved template has been written to config.json")
    return resp.headers["ETag"]


def _listVersions():
    headers = {"Authorization": "Bearer " + _get_access_token()}
    resp = requests.get(REMOTE_CONFIG_URL + ":listVersions?pageSize=5", headers=headers)

    if resp.status_code == 200:
        print("Versions:")
        print(resp.text)
    else:
        print("Request to print template versions failed.")
        print(resp.text)


def _rollback(version):
    headers = {"Authorization": "Bearer " + _get_access_token()}

    json = {"version_number": version}
    resp = requests.post(REMOTE_CONFIG_URL + ":rollback", headers=headers, json=json)

    if resp.status_code == 200:
        print("Rolled back to version: " + version)
        print(resp.text)
        print("ETag from server: {}".format(resp.headers["ETag"]))
    else:
        print("Request to roll back to version " + version + " failed.")
        print(resp.text)

def _publish():
    etag = _get()
    with open("./config.json", "r", encoding="utf-8") as f:
        content = f.read()
    headers = {
        "Authorization": "Bearer " + _get_access_token(),
        "Content-Type": "application/json; UTF-8",
        "If-Match": etag,
    }
    print(content)
    j = json.loads(content)
    j['parameters']['app_secret']['defaultValue']['value'] = os.getenv("BUILD_VERSION")

    content = json.dumps(j)
    resp = requests.put(
        REMOTE_CONFIG_URL, data=content.encode("utf-8"), headers=headers
    )
    if resp.status_code == 200:
        print("Template has been published.")
        print("ETag from server: {}".format(resp.headers["ETag"]))
    else:
        print("Unable to publish template.")
        print(resp.text)

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--action")
    parser.add_argument("--etag")
    parser.add_argument("--version")
    args = parser.parse_args()

    if args.action and args.action == "get":
        _get()
    elif args.action and args.action == "publish":
        _publish()
    elif args.action and args.action == "versions":
        _listVersions()
    elif args.action and args.action == "rollback" and args.version:
        _rollback(args.version)
    else:
        print(
            """Invalid command. Please use one of the following commands:
                python configure.py --action=get
                python configure.py --action=publish
                python configure.py --action=versions
                python configure.py --action=rollback --version=<TEMPLATE_VERSION_NUMBER>
            """
        )

if __name__ == "__main__":
    main()