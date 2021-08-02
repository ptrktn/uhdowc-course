# BZ Elementary Reaction Helper Wrapper

## Description

A Docker wrapper for
[erhelper](https://github.com/ptrktn/bz/tree/main/erhelper) tool to
convert kinetic reaction system model to C header file.

## Usage

`docker run -it --rm bz-erhelper-wrapper URL`

The `URL` specifies the model. If none given, the default is
Lotka-Volterra model.

## Example

`docker run -it --rm bz-erhelper-wrapper https://raw.githubusercontent.com/ptrktn/bz/main/erhelper/examples/brusselator.txt`

## Links

[https://hub.docker.com/r/uhdowccourse/bz-erhelper-wrapper](https://hub.docker.com/r/uhdowccourse/bz-erhelper-wrapper)



