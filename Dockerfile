# first stage does the building
# for UX purposes, I'm naming this stage `build-stage`

FROM golang:1.8 as build-stage
WORKDIR /go/src/github.com/codeship/go-hello-world
COPY hello-full-cycle.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello-full-cycle .


# starting second stage
FROM scratch

# copy the binary from the `build-stage`
COPY --from=build-stage /go/src/github.com/codeship/go-hello-world/hello-full-cycle /hello

ENTRYPOINT ["/hello"]