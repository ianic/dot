#!/bin/bash -e

# sudo snap install multipass
# multipass find --show-unsupported

images=("22.04" "21.10" "21.04" "20.10" "20.04") # stariji
images=("20.04" "20.10" "21.04" "21.10" "22.04" "22.10")

images=("23.04" "22.04" "20.04") # arm
images=("20.04" "20.10" "21.04" "21.10" "22.04" "22.10" "23.04" "23.10")
images=("23.10" "23.04" "22.10" "22.04" "21.10" "21.04" "20.10" "20.04")




# cp /usr/local/bin/zig zig-bin
# for image in "${images[@]}"; do
#     host=u$(echo $image | tr . -)
# 
#     multipass launch -n $host $image || multipass start $host
#     multipass transfer zig-bin $host:zig
#     multipass mount $zig_dir $host:/home/ubuntu/src || true
# 
#     multipass exec $host --working-directory /home/ubuntu/src -- uname -a
#     multipass exec $host --working-directory /home/ubuntu/src -- \
#         /home/ubuntu/zig test lib/std/std.zig \
#         --zig-lib-dir lib \
#         --main-mod-path lib/std \
#         --test-filter "ring mapped"
# 
#     multipass stop $host
# done
# rm zig-bin

cd ~/zig/zig && mkdir -p zig-out
zig test lib/std/std.zig --zig-lib-dir lib --main-mod-path lib/std -femit-bin=zig-out/test


zig_test=~/code/zig/zig-out/test # mac
zig_test=~/zig/zig/zig-out/test

log_dir=log/$(date +%Y-%m-%dT%H-%M)
mkdir -p $log_dir

function test() {
    # wait for exec to be available 
    # getting error: exec failed: ssh failed to authenticate: 'Socket error: disconnected'
    # first few seconds
    while ! multipass exec $host -- true; do; true ;done

    multipass transfer $zig_test $host:/home/ubuntu/test
    kernel=$(multipass exec $host -- uname -r)
    echo running test on $host, kernel $kernel
    multipass exec $host -- /home/ubuntu/test 2>&1 | cat >$log_dir/$host-$kernel.log
}

# run tests on all images
for image in "${images[@]}"; do
    host=u$(echo $image | tr . -)
    multipass start $host
    test
    multipass stop $host
done

# launch, test, stop 
for image in "${images[@]}"; do
    host=u$(echo $image | tr . -)
    multipass launch -n $host $image
    #test
    multipass stop $host
done

# remove all images
multipass ls
for image in "${images[@]}"; do
    host=u$(echo $image | tr . -)
    multipass stop $host
    multipass delete $host
done
multipass purge









for image in "${images[@]}"; do
    host=u$(echo $image | tr . -)
    multipass transfer $zig_test $host:/home/ubuntu/test
    kernel=$(multipass exec $host -- uname -r)
    multipass exec $host -- /home/ubuntu/test 
done
