class SliderModel{
    int id , type  , referenceId ;
    String url ,  image , title ;

    SliderModel({
      this.id, this.type, this.referenceId, this.url, this.image, this.title});


    SliderModel.fromJson(Map<String , dynamic> json){
      id = json['id'] ;
      type = json['type'] ;
      referenceId = json['reference_id'];
      url = json['url'] ;
      image = json['image'];
      title = json['title'] ;
    }

}