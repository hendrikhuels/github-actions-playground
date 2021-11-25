#-------------------- Bob the builder --------------------
FROM golang:1.17.3 as builder

WORKDIR /go/src/app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -tags netgo -ldflags '-w -extldflags " -static"' -o a.out *.go


#-------------------- Base container --------------------
FROM scratch as app

COPY --from=builder /go/src/app/a.out /a.out

ENTRYPOINT ["/a.out"]
