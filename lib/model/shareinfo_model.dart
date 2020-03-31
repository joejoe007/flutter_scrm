class ShareInfoModel {
    Message message;
    dynamic scene;

    ShareInfoModel({this.message, this.scene});

    factory ShareInfoModel.fromJson(Map<String, dynamic> json) {
        return ShareInfoModel(
            message: json['message'] != null ? Message.fromJson(json['message']) : null,
            scene: json['scene'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['scene'] = this.scene;
        if (this.message != null) {
            data['message'] = this.message.toJson();
        }
        return data;
    }
}

class Message {
    String description;
    Media media;
    String title;
    String thumb;
    Message({this.description, this.media, this.title, this.thumb});

    factory Message.fromJson(Map<String, dynamic> json) {
        return Message(
            description: json['description'],
            media: json['media'] != null ? Media.fromJson(json['media']) : null,
            title: json['title'],
            thumb: json['thumb'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['description'] = this.description;
        data['title'] = this.title;
        if (this.media != null) {
            data['media'] = this.media.toJson();
        }
        data['thumb'] = this.thumb;
        return data;
    }
}

class Media {
    dynamic type;
    String webpageUrl;

    Media({this.type, this.webpageUrl});

    factory Media.fromJson(Map<String, dynamic> json) {
        return Media(
            type: json['type'],
            webpageUrl: json['webpageUrl'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['type'] = this.type;
        data['webpageUrl'] = this.webpageUrl;
        return data;
    }
}