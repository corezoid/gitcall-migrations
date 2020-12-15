#!/usr/bin/env bash
$CZ helm template | sed -n '/job\.yaml/,/Source\:/p'
