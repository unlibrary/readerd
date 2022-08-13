# Unlibrary daemon

aka `readerd` or `unlibd`

This project acts as a layer between [Unlibrary reader](https://github.com/unlibrary/reader) and clients such as [Unlibrary CLI](https://github.com/unlibrary/cli) (and in the future maybe even a local web client).

It can be started in the background as an erlang/elixir node and can be connected to by clients. This means all NIFs, database interaction and other stuff hard to put into a binary (like `uncli`) can be delegated to the server.

Apart from that the server will also handle authentication. This does mean however, that only one user can be used across clients.

## Installation

Coming soon. I will probably also create a horrible but functional PKGBUILD for Arch :)

## Usage

If running in dev mode (aka git cloning the source code):

```shell
$ ./dev.sh
Running on readerd@delta.localdomain
```

If installed via the future PKGBUILD:

```shell
$ readerd
Running on readerd@delta.localdomain
```

The daemon will print its node name which you can use to connect to it.
