default: list
image = "mids-w205-tools-1553698606"
bucket = "gs://mids-w205/"

list:
	@echo "---" $@ "---"
	@gsutil ls -lh $(bucket)

build: build_gcp
	@echo "---" $@ "---"

build_gcp:
	@echo "---" $@ "---"
	@time packer build -var-file=variables.json gcp.json

publish:
	@echo "---" $@ "---"
	@echo gcloud compute images export --destination-uri $(bucket)$(image).tar.gz --image $(image)
