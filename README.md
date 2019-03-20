# [xTeVe](https://xteve.de/) + [zap2xml](http://zap2xml.awardspace.info/) Docker Container

### Docker usage
```
docker create \
  --name=zap2xteve \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e ZAP2XML_USERNAME=none \
  -e ZAP2XML_PASSWORD=none \
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
| `-e XTEVE_PORT=34400` | The port for the xTeVe webinterface |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use ex/Europe/London |
| `-e TVGUIDE_EPG=FALSE` | Specify whether to use TVGuide instead of Zap2it |
| `-e ZAP2XML_USERNAME=none` | Specify username for either Zap2it or TVGuide |
| `-e ZAP2XML_PASSWORD=none` | Specify password for either Zap2it or TVGuide |
| `-e XMLTV_FILENAME=xmltv.xml` | Specify filename for zap2xml EPG-XML file |
| `-e ZAP2XML_ARGS= -D -I -F -L -T -O -b` | Specify additional arguements for zap2xml (http://zap2xml.awardspace.info) |
| `-e XML_UPDATE_INTERVAL=24` | Specify update interval for zap2xml (in hours). |
| `-v /config` | Location of xTeVe config files |
| `-v /data` | Location of zap2xml EPG-XML file |
| `-v /cache` | Location of zap2xml cache |
