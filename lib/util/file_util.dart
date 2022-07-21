extension StringExtension on String {
  bool get isPic {
    if (this.endsWith('jpg') ||
        this.endsWith('JPG') ||
        this.endsWith('png') ||
        this.endsWith('PNG') ||
        this.endsWith('jpeg') ||
        this.endsWith('JPEG') ||
        this.endsWith('bmp') ||
        this.endsWith('BMP') ||
        this.endsWith('webp') ||
        this.endsWith('WEBP') ||
        this.endsWith('GIF') ||
        this.endsWith('gif')) {
      return true;
    }
    return false;
  }

  bool get isVideo {
    if (this.endsWith('mp4') ||
        this.endsWith('MP4') ||
        this.endsWith('avi') ||
        this.endsWith('AVI') ||
        this.endsWith('wmv') ||
        this.endsWith('WMV') ||
        this.endsWith('mov') ||
        this.endsWith('MOV') ||
        this.endsWith('FLV') ||
        this.endsWith('flv')) {
      return true;
    }
    return false;
  }

  bool get isMedia {
    return this.isPic || this.isVideo;
  }

  bool get isAudio {
    if (this.endsWith('mp3') ||
        this.endsWith('wav') ||
        this.endsWith('vma') ||
        this.endsWith('cda') ||
        this.endsWith('ape')) {
      return true;
    }
    return false;
  }
}

class FileUtil {
  static FileUtil instance = FileUtil._internal();
  factory FileUtil() {
    return instance;
  }
  static String? temporaryDirectory;
  FileUtil._internal();
  List mediaList = [];
  List getFileList(List filse) {
    List dirList = [];
    List picList = [];
    List vidoeList = [];
    List audioList = [];
    List fileLsit = [];
    for (int i = 0; i < filse.length; i++) {
      var file = filse[i];
      String fileName = file['name'];
      if (file['dir']) {
        dirList.add(file);
      } else if (fileName.isAudio) {
        audioList.add(file);
      } else if (fileName.isPic) {
        picList.add(file);
      } else if (fileName.isVideo) {
        vidoeList.add(file);
      } else {
        fileLsit.add(file);
      }
    }
    mediaList = picList + vidoeList;
    return dirList + audioList + picList + vidoeList + fileLsit;
  }
}
