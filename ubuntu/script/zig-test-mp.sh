#!/bin/bash -e

# multipass find --show-unsupported
images=("20.04" "22.04" "24.04" "devel")

function help_()
{
   echo "Run zig test binary on different kernels"
   echo
   echo "Syntax: zig-test-mp.sh [-p|b|r|c|h]"
   echo "options:"
   echo "p     Prepare multipass, install multipass download images"
   echo "b     Build test binary"
   echo "r     Run test binary on all images"
   echo "c     Cleanup remove all images"
   echo "h     Print this Help."
   echo
}

function test() {
    # wait for exec to be available
    # getting error: exec failed: ssh failed to authenticate: 'Socket error: disconnected'
    # first few seconds
    while ! multipass exec $host -- true ; do
        true
    done

    multipass transfer $zig_test $host:/home/ubuntu/test
    kernel=$(multipass exec $host -- uname -r)
    echo running test on $host, kernel $kernel
    multipass exec $host -- /home/ubuntu/test 2>&1 | cat >$log_dir/$host-$kernel.log
}

while getopts ":pbrch" option; do
   case $option in
       p)
           sudo snap install multipass
           for image in "${images[@]}"; do
               host=u$(echo $image | tr . -)
               if [[ ! "$(multipass info $host)" ]]; then
                  multipass launch -n $host $image
                  multipass stop $host
               else
                   echo host $host for image $image exists
               fi
           done
           ;;
       b)
           cd ~/Code/zig && mkdir -p zig-out
           zig test lib/std/std.zig --zig-lib-dir lib -femit-bin=zig-out/test
           ;;
       r)
           zig_test=~/Code/zig/zig-out/test
           now=$(date +%Y-%m-%dT%H-%M)
           log_dir=log/$now
           mkdir -p $log_dir
           cd log && rm -f latest && ln -s $now latest && cd ..
           echo using log dir $log_dir
           # run tests on all images
           for image in "${images[@]}"; do
               host=u$(echo $image | tr . -)
               multipass start $host
               test
               multipass stop $host
           done
           ;;
       c)
           #remove all images
           multipass ls
           for image in "${images[@]}"; do
               host=u$(echo $image | tr . -)
               multipass stop $host
               multipass delete $host
           done
           multipass purge
           ;;
       h)
           help_
           exit;;
       \?) # Invalid option
           echo "Error: Invalid option"
           help_
           exit;;
   esac
done
