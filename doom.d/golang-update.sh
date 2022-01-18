# emacs install
#brew install emacs-plus --with-gnu-head-icon
brew install emacs-mac
# trenutno koristim: /usr/local/Cellar/emacs-mac/emacs-27.1-mac-8.1 i tu radi full screen
# s emacs-plus varijantama imam problema u fullscreen, otvori jos jedan frame

# go upgrade
brew upgrade go

go get -u golang.org/x/tools/gopls@latest

go get -u github.com/motemen/gore/cmd/gore
go get -u github.com/stamblerre/gocode
go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u github.com/cweill/gotests/...
go get -u github.com/fatih/gomodifytags

brew install golangci-lint
brew upgrade golangci-lint

# solving doom doctor problem:
#      ! Couldn't find stylelint. Linting for CSS modes will not work.
#      ! Couldn't find js-beautify. Code formatting in JS/CSS/HTML modes will not work.
# npm install -g stylelint
# npm -g install js-beautify
