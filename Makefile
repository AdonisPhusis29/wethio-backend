.PHONY: zyn zyn-cross evm all test clean
.PHONY: zyn-linux zyn-linux-386 zyn-linux-amd64 zyn-linux-mips64 zyn-linux-mips64le
.PHONY: zyn-darwin zyn-darwin-386 zyn-darwin-amd64

GOBIN = $(shell pwd)/build/bin
GOFMT = gofmt
GO ?= latest
GO_PACKAGES = .
GO_FILES := $(shell find $(shell go list -f '{{.Dir}}' $(GO_PACKAGES)) -name \*.go)

GIT = git

zyn:
	build/env.sh go run build/ci.go install ./cmd/zyn
	@echo "Done building."
	@echo "Run \"$(GOBIN)/zyn\" to launch zyn."

gc:
	build/env.sh go run build/ci.go install ./cmd/gc
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gc\" to launch gc."

bootnode:
	build/env.sh go run build/ci.go install ./cmd/bootnode
	@echo "Done building."
	@echo "Run \"$(GOBIN)/bootnode\" to launch a bootnode."

puppeth:
	build/env.sh go run build/ci.go install ./cmd/puppeth
	@echo "Done building."
	@echo "Run \"$(GOBIN)/puppeth\" to launch puppeth."

all:
	build/env.sh go run build/ci.go install

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# Cross Compilation Targets (xgo)

zyn-cross: zyn-windows-amd64 zyn-darwin-amd64 zyn-linux
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/zyn-*

zyn-linux: zyn-linux-386 zyn-linux-amd64 zyn-linux-mips64 zyn-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-*

zyn-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/zyn
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep 386

zyn-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/zyn
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep amd64

zyn-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/zyn
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep mips

zyn-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/zyn
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep mipsle

zyn-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/zyn
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep mips64

zyn-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/zyn
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/zyn-linux-* | grep mips64le

zyn-darwin: zyn-darwin-386 zyn-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/zyn-darwin-*

zyn-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/zyn
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-darwin-* | grep 386

zyn-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/zyn
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-darwin-* | grep amd64

zyn-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/zyn
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/zyn-windows-* | grep amd64
gofmt:
	$(GOFMT) -s -w $(GO_FILES)
	$(GIT) checkout vendor
