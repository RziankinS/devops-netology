1.	git show aefea
commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Update CHANGELOG.md

2.	git show 85024d3
tag: v0.12.23 - commit 85024d3100126de36331c6982bfaac02cdab9e76

3.	git show -s --format=%p b8d720
56cd7859e 9ea88f22f
или, полный кэш коммитов
	git show --pretty=format:' %P' b8d720
56cd7859e05c36c06b56d013b55a252d0bb7e158 
9ea88f22fc6269854151c571162c5bcf958bee2b

4.	git log  v0.12.23..v0.12.24  --oneline
33ff1c03b (tag: v0.12.24) v0.12.24
b14b74c49 [Website] vmc provider links
3f235065b Update CHANGELOG.md
6ae64e247 registry: Fix panic when server is unreachable
5c619ca1b website: Remove links to the getting started guide's old location
06275647e Update CHANGELOG.md
d5f9411f5 command: Fix bug when using terraform login on Windows
4b6d06cc5 Update CHANGELOG.md
dd01a3507 Update CHANGELOG.md
225466bc3 Cleanup after v0.12.23 release

5.	git log -S 'func providerSource(' --oneline
8c928e835 main: Consult local directories as potential mirrors of providers

6.	git grep 'func globalPluginDirs'
plugins.go:func globalPluginDirs() []string {
	git log -L 'func globalPluginDirs':plugins.go --oneline
78b122055 Remove config.go and update things using its aliases
52dbf9483 keep .terraform.d/plugins for discovery
41ab0aef7 Add missing OS_ARCH dir to global plugin paths
66ebff90c move some more plugin search path logic to command
8364383c3 Push plugin discovery down into command package

7.	git log -S 'synchronizedWriters' --oneline
	git show 5ac311e2a
Author: Martin Atkins <mart@degeneration.co.uk>
