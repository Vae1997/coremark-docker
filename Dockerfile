FROM alpine
COPY tools/* /tmp/
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update \
 && apk add --no-cache gcc musl-dev \
 && tar -xf /tmp/coremark.tar.gz -C /root/ \
 && mkdir /root/result/ && mv /tmp/test-pthread.sh /root/result/ \
 && cd /root/coremark/ && gcc -march=armv8-a -mtune=cortex-a53 -O3 -Ilinux64 -I. -DFLAGS_STR=\""-march=armv8-a -mtune=cortex-a53 -O3 -DMULTITHREAD=4 -DUSE_PTHREAD -DPERFORMANCE_RUN=1 -lrt"\" -DITERATIONS=0 -DMULTITHREAD=4 -DUSE_PTHREAD -DPERFORMANCE_RUN=1 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c linux64/core_portme.c -o ./coremark.exe -lrt \
 && mv coremark.exe /root/ && cd /root/ && rm -rf coremark/ \
 && apk del --purge gcc musl-dev \
 && rm -rf /var/cache/apk/* && rm -rf /var/lib/apk/* && rm -rf /etc/apk/cache/* \
 && rm /tmp/coremark.tar.gz
# cd /root/result/ && sh test-pthread.sh
