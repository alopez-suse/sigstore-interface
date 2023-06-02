.PHONY: 

BASE_IMAGE_TAG = latest
BUILD_IMAGE_TAG = v1

all:
	env GOOS=linux GOARCH=amd64 go build -ldflags='-s -w' -buildvcs=false .

binary:
	@echo "Making $@ ..."
	@docker pull neuvector/build_fleet:${BUILD_IMAGE_TAG}
	@docker run --rm -ia STDOUT --name build --net=none -v $(CURDIR):/go/src/github.com/neuvector/sigstore-interface -w /go/src/github.com/neuvector/sigstore-interface --entrypoint ./make_bin.sh neuvector/build_fleet:${BUILD_IMAGE_TAG}
