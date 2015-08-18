# Usage of Image Magick's container

Since Catabooru used Image Magick (IM) to generate thumbnails, it seems normal
to use it here too. Except, IM is installed by default and especially is not 
installed in Elixir container. So we have a choice:

## Create our own Elixir container with IM installed.

A lot of effort to update image, plus it's not the 'Dockers way'

## Install IM in runtime.

As a quick solution, yes. In a long run, no.

## Create IM container with TaaS (Thumbnail as a Service).

Seems like an interesting idea. Could be useful in different projects.
Still, a lot of work to do.

## Create cron script that will regenerate thumbnails from outside.

Quick and easy.

## Use different library.

There are no image manipulation libraries in pure Elixir / Erlang.

