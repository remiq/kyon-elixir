#!/usr/bin/env bash

env $(cat ../.env | xargs) iex -S mix
