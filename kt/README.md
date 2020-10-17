# keytool -genkey -v -keystore ~/sign.jks -keyalg RSA -keysize 2048 -validity 10000 -alias sign
# keytool -list -v -keystore /Users/wangli/sign.jks
# CN=wangli, OU=owo, O=owo, L=Guangzhou, ST=Guangdong, C=CN
keytool -genkey -keyalg RSA -alias oranda -keystore release.jks -storepass oranda -keypass oranda -validity 360 -keysize 2048
# 
