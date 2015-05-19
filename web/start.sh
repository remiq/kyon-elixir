#!/usr/bin/env bash

env $(cat ../.env | xargs) mix phoenix.server