#!/bin/bash

#gcloud builds submit --config=cloudbuild.yaml --substitutions=_LOCATION="us-east1",_REPOSITORY="my-repo",_PACKAGE="my-package" .
gcloud builds submit --config=cloudbuild_frappe_worker.yaml
gcloud builds submit --config=cloudbuild_frappe_nginx.yaml
gcloud builds submit --config=cloudbuild_erpnext_worker.yaml
gcloud builds submit --config=cloudbuild_erpnext_nginx.yaml
gcloud builds submit --config=cloudbuild_frappe_socketio.yaml
