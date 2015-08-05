#!/bin/sh 
#
# Copyright (c) 2015 Alaganraj Sandhanam <alaganraj.sandhanam@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

sudo media-ctl -v -r -l '"mt9p031 1-0048":0->"OMAP3 ISP CCDC":0[1], "OMAP3 ISP CCDC":2->"OMAP3 ISP preview":0[1], "OMAP3 ISP preview":1->"OMAP3 ISP resizer":0[1], "OMAP3 ISP resizer":1->"OMAP3 ISP resizer output":0[1]'

echo "Link setup done!"

sudo media-ctl -v -f '"mt9p031 1-0048":0 [SGRBG12 1024x768], "OMAP3 ISP CCDC":2 [SGRBG10 1024x768], "OMAP3 ISP preview":1 [UYVY 10006x760], "OMAP3 ISP resizer":1 [UYVY 1024x768]'

echo "Set format done"

####### stream #########
#sudo yavta -f UYVY -s 1024x768 -n 8 --skip 3 --capture=1000 --stdout /dev/video6 | mplayer - -demuxer rawvideo -rawvideo w=1024:h=768:format=uyvy -vo fbdev

################################# 
#    capture to file
#################################

# multi capture
sudo yavta -f UYVY -s 1024x768 --capture=10 --file=img-uyvy-1024x768-#.yuv /dev/video6

# single capture
#sudo yavta -f UYVY -s 1024x768 --capture=10 --file=img-uyvy-1024x768.yuv /dev/video6

echo "Success !!!"

