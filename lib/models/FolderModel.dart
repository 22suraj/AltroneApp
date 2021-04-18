class FolderModel {
  String id;
  String folderName;
  String imageurl;

  FolderModel({this.folderName, this.imageurl});

  FolderModel.fromMap(Map snapshot, String id)
      : id = id ?? '',
        folderName = snapshot['Folder-Name'] ?? '',
        imageurl = snapshot['Image-URL'] ?? '';

  toJSON() {
    return {"Folder-Name": folderName, "Image-URL": imageurl};
  }
}
