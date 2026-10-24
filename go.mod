module github.com/centrifugal/protocol

go 1.26.0

require (
	github.com/mailru/easyjson v0.9.2
	github.com/segmentio/encoding v0.5.4
	github.com/stretchr/testify v1.12.1
	github.com/valyala/bytebufferpool v1.0.0
	google.golang.org/protobuf v1.36.12
)

require (
	github.com/FZambia/gomodifytype v0.0.0-20210512075931-2bcb28c5dd7e // indirect
	github.com/fatih/camelcase v1.0.0 // indirect
	github.com/fatih/gomodifytags v1.17.0 // indirect
	github.com/fatih/structtag v1.2.0 // indirect
	github.com/josharian/intern v1.0.0 // indirect
	github.com/planetscale/vtprotobuf v0.6.0 // indirect
	github.com/segmentio/asm v1.2.1 // indirect
	go.yaml.in/yaml/v3 v3.0.5 // indirect
	golang.org/x/mod v0.42.0 // indirect
	golang.org/x/sync v0.24.0 // indirect
	golang.org/x/sys v0.49.0 // indirect
	golang.org/x/telemetry v0.0.0-20261021172232-6cd571d43fbb // indirect
	golang.org/x/tools v0.52.0 // indirect
)

tool (
	github.com/FZambia/gomodifytype
	github.com/fatih/gomodifytags
	github.com/mailru/easyjson/easyjson
	github.com/planetscale/vtprotobuf/cmd/protoc-gen-go-vtproto
	golang.org/x/tools/cmd/goimports
	google.golang.org/protobuf/cmd/protoc-gen-go
)
