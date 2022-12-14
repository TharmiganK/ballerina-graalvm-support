native-image -jar <path-to-the-jar-file> \
  --no-fallback \
  --enable-url-protocols=http,https \
  --initialize-at-build-time=org.slf4j \
  --initialize-at-run-time=io.netty.handler.ssl.BouncyCastleAlpnSslUtils \
  --initialize-at-run-time=io.netty.handler.codec.http2 \
  --initialize-at-run-time=io.netty.handler.codec.compression.ZstdOptions \
  --initialize-at-run-time=io.netty.handler.ssl.OpenSsl \
  --initialize-at-run-time=io.netty.handler.ssl.OpenSslPrivateKeyMethod \
  --initialize-at-run-time=io.netty.handler.ssl.ReferenceCountedOpenSslEngine  \
  --initialize-at-run-time=io.netty.internal.tcnative \
  --initialize-at-run-time=io.netty.handler.ssl.OpenSslAsyncPrivateKeyMethod \
  -H:ResourceConfigurationFiles=common-configs/resource-config.json \
  -H:ReflectionConfigurationFiles=common-configs/reflect-config.json\
  -H:JNIConfigurationFiles=common-configs/jni-config.json \
  -H:DynamicProxyConfigurationFiles=common-configs/proxy-config.json \
  -H:SerializationConfigurationFiles=common-configs/serialization-config.json \
  -H:MaxDuplicationFactor=25.0 \
  -H:Name=<name-of-the-image>
