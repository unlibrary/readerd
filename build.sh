#!/bin/bash

elixir -v && MIX_ENV=prod mix release
