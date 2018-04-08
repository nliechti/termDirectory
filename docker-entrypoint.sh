#!/bin/sh

sleep 10 #Wait for db to start before running the migration

mix ecto.create && \
	mix	ecto.migrate

mix phx.server