#!/usr/bin/env bash

set -euo pipefail

$(swww query || swww-daemon)
