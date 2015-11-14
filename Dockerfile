FROM 		sixeyed/coreclr-base
MAINTAINER 	Thibault Deheurles <tdeheurles@gmail.com>

# ensure the expected DNX is available
ENV 		PATH /root/.dnx/runtimes/dnx-coreclr-linux-x64.1.0.0-beta8-15618/bin:$PATH
