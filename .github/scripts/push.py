import requests
import json
import os

def get_asset_id():
    return "2063"

print(f"Logging in to Godot Asset Library as {os.environ.get('USERNAME')}...")
login_response = requests.post("https://godotengine.org/asset-library/api/login", data={"username": os.environ["USERNAME"], "password": os.environ["PASSWORD"]})
login_response.raise_for_status()

response = json.loads(login_response.text)
token = response["token"]

download_url = f"https://github.com/{os.environ['GITHUB_REPOSITORY']}/releases/download/{os.environ['VERSION']}/poing-godot-admob-{os.environ['VERSION']}.zip"

asset_data = {
    "token": token,
    "version_string": os.environ["VERSION"],
    "download_commit": download_url
}

print(f"Attempting to update asset {get_asset_id()}...")
print(f"Version: {os.environ['VERSION']}")
print(f"Download URL: {download_url}")

upload_response = requests.post("https://godotengine.org/asset-library/api/asset/" + get_asset_id(), data=asset_data)

if upload_response.status_code == 200:
    print("Asset updated with success!")
else:
    print(f"Error {upload_response.status_code} while updating the asset.")
    try:
        error_details = upload_response.json()
        print(f"Details: {json.dumps(error_details, indent=2)}")
    except:
        print(f"Raw Response: {upload_response.text}")
    upload_response.raise_for_status()
