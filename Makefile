.PHONY=project

# You can set the current project as an environment variable
#  This means you can type in `make` instead of `make project_name`
project?=

ifeq ($(project),)
project:
	${error No project was specified! Please run `export project=<project_name>`}
else
project: ${project}
endif

# A way to tack on extra arguments so you don't need to type out stuff
args?=


comment-eg.txt:
	echo "example!" > comment-eg.txt
	# This comment is GOING PLACES!


draw_circle: draw_circle.c
	gcc draw_circle.c -lm -o draw_circle ${args}
