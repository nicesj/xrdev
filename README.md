# Prepare the build environment

```bash
$ docker build . -f Dockerfile -t registry.nicesj.com/xrdev:latest
$ docker run -i -t -v $PWD:/root/workspace --network host registry.nicesj.com/xrdev:latest
```

# Reference
[1] Durrant-Whyte, Hugh, and Tim Bailey. "Simultaneous localization and mapping: part I." IEEE robotics & automation magazine 13.2 (2006): 99-110.

[2] Bailey, Tim, and Hugh Durrant-Whyte. "Simultaneous localization and mapping (SLAM): Part II." IEEE robotics & automation magazine 13.3 (2006): 108-117. 

[3] Visual SLAM번역. https://www.cv-learn.com/20210123-slam-book-translation/

[4] slam이론 유튜브 영상. SLAM KR community (2020), https://www.cv-learn.com/20210120-slam-dunk-2/

[5] SOTA Algorithm Code. https://paperswithcode.com/sota/

[6] 서울 XR 실증센터. http://seoulxrcenter.kr/index.php?hCode=BOARD_05_03&bo_idx=3
