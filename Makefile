# Copyright © 2020 WorldRIZe. All rights reserved.

.PHONY: init
init:
	:
	# TODO: download firebase app config
	# TODO: download assets/

.PHONY: gen
gen:
	# flutter pub run build_runner build --delete-conflicting-outputs
	# sh scripts/update_i10n.sh
	# python scripts/convertor.py
	# python scripts/rename.py
	flutter pub pub run flutter_native_splash:create
	flutter packages pub run flutter_launcher_icons:main