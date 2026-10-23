#!/bin/bash

set -euo pipefail

# Requires protoc on PATH; Go tools are pinned in go.mod.

which protoc
go tool protoc-gen-go --version

protoc --go_out=. --plugin protoc-gen-go="$(go tool -n protoc-gen-go)" --go-vtproto_out=. \
  --plugin protoc-gen-go-vtproto="$(go tool -n protoc-gen-go-vtproto)" \
  --go-vtproto_opt=features=marshal+unmarshal+size \
  client.proto

go tool gomodifytype -file client.pb.go -all -w -from "[]byte" -to "Raw"

echo "replacing tags of structs for JSON backwards compatibility..."
go tool gomodifytags -file client.pb.go -field User -struct ClientInfo -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field Client -struct ClientInfo -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field Presence -struct PresenceResult -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field NumClients -struct PresenceStatsResult -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field NumUsers -struct PresenceStatsResult -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field Offset -struct HistoryResult -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field Epoch -struct HistoryResult -all -w -remove-options json=omitempty >/dev/null
go tool gomodifytags -file client.pb.go -field Publications -struct HistoryResult -all -w -remove-options json=omitempty >/dev/null

# compile easy json in separate dir since we are using custom writer here.
mkdir build
cp client.pb.go build/client.pb.go
cp raw.go build/raw.go
(
  cd build
  go tool easyjson -all -no_std_marshalers client.pb.go
)
# move compiled to current dir.
cp build/client.pb_easyjson.go ./client.pb_easyjson.go
rm -rf build

# need to replace usage of jwriter.Writer to custom writer.
find . -name 'client.pb_easyjson.go' -print0 | xargs -0 sed -i "" "s/jwriter\.W/w/g"
# need to replace usage of jwriter package constants to local writer constants.
find . -name 'client.pb_easyjson.go' -print0 | xargs -0 sed -i "" "s/jwriter\.N/n/g"
# cleanup formatting.
go tool goimports -w client.pb_easyjson.go

# Copy to definitions folder for docs link backwards compatibility.
cp client.proto definitions/client.proto
