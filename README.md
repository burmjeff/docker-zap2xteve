# [xTeVe](https://github.com/xteve-project/xTeVe) + [zap2xml](https://web.archive.org/web/20200426004001/http://zap2xml.awardspace.info/) Docker Container

### Docker usage
```
docker create \
  --name=zap2xteve \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e ZAP2XML_USERNAME= \
  -e ZAP2XML_PASSWORD= \
  -p 34400:34400 \
  -v <path to config>:/config \
  -v <path to data>:/data \
  -v <path to cache>:/cache \
  --restart unless-stopped \
  burmjeff/zap2xteve
```

## Parameters
| Parameter | Function |
| :----: | --- |
| `-p 34400` | The exposed port for the xTeVe webinterface |
| `-e HOST_IP=` | Manually set an IP to use for xTeve Host IP |
| `-e XTEVE_PORT=34400` | The port for the xTeVe webinterface |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use ex/Europe/London |
| `-e TVGUIDE_EPG=FALSE` | Specify whether to use TVGuide instead of Zap2it |
| `-e ZAP2XML_USERNAME=` | Specify username for either Zap2it or TVGuide |
| `-e ZAP2XML_PASSWORD=` | Specify password for either Zap2it or TVGuide |
| `-e ZAP2XML_ARGS= -D -I -F -L -T -O -b` | Specify additional arguments for zap2xml (http://zap2xml.awardspace.info) |
| `-e XMLTV_FILENAME=xmltv.xml` | Specify filename for zap2xml EPG-XML file |
| `-e XML_UPDATE_INTERVAL=24` | Specify update interval for zap2xml (in hours). |
| `-v /config` | Location of xTeVe config files |
| `-v /data` | Location of zap2xml EPG-XML file |
| `-v /cache` | Location of zap2xml cache |

## Using Multiple zap2xml users/guides
```
Add as many zap2xml user details as wanted (users must be sequentially numbered). 
(OPTIONAL): Add separate zap2xml arguments for each user by following the numbering scheme.  Will use default (ZAP2XML_ARGS) if no numbered (ZAP2XML_ARGS_#) is provided.
For example:
```
| Parameter | Function |
| :----: | --- |
| `-e ZAP2XML_USERNAME_1=` | Specify username 1 for either Zap2it or TVGuide |
| `-e ZAP2XML_PASSWORD_1=` | Specify password 1 for either Zap2it or TVGuide |
| `-e ZAP2XML_ARGS_1= -D` | (OPTIONAL) Specify additional arguments for zap2xml (http://zap2xml.awardspace.info) |
| `-e ZAP2XML_USERNAME_2=` | Specify username 2 for either Zap2it or TVGuide |
| `-e ZAP2XML_PASSWORD_2=` | Specify password 2 for either Zap2it or TVGuide |
| `-e ZAP2XML_ARGS_2= -z` | (OPTIONAL) Specify additional arguments for zap2xml (http://zap2xml.awardspace.info) |
| `-e ZAP2XML_USERNAME_3=` | Specify username 3 for either Zap2it or TVGuide |
| `-e ZAP2XML_PASSWORD_3=` | Specify password 3 for either Zap2it or TVGuide |
| `-e ZAP2XML_ARGS_3= -D -I -F -L` | (OPTIONAL) Specify additional arguments for zap2xml (http://zap2xml.awardspace.info) |
