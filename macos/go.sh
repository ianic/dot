#!/bin/bash -ex

# go upgrade
brew upgrade go
brew install golangci-lint
brew upgrade golangci-lint

go install golang.org/x/tools/gopls@latest
go install github.com/stamblerre/gocode@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/cmd/guru@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/x-motemen/gore/cmd/gore@latest
go install github.com/google/pprof@latest
# go get -u github.com/cweill/gotests/...

# brew install fd
# brew install shellcheck
# brew install grip markdown

# notes:
# reset lsp ignored projects
#(setf (lsp-session-folders-blacklist (lsp-session)) nil)
#(lsp--persist-session (lsp-session))
