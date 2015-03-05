APP_FILES=$(shell find . -type f -name '*.lua')

statsd: lit $(APP_FILES)
	./lit make

test: lit
	./lit install
	LUVI_APP=. LUVI_MAIN=tests/main.lua ./lit

clean:
	rm -rf statsd lit lit-* luvi deps

lit:
	curl -L https://github.com/luvit/lit/raw/0.11.0/get-lit.sh | sh

install: statsd lit
	install statsd /usr/local/bin

uninstall:
	rm -f /usr/local/bin/statsd

lint:
	find . -name "*.lua" | xargs luacheck

.PHONY: test lit install lint
