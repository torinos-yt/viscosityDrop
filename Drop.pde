final int N_PARTICLES = 30; // 一つの雫に含まれる円の数を指定
final float DROP_DIST = 280; // 雫が落ちるまでの距離

float speed = 1; //落下スピード

class Drop{
  PVector position;
  PVector rootPos;
  float radius;
  boolean dropped;
  
  Drop(PVector pos, float rad){
    this.position = pos.copy();
    this.rootPos = pos.copy();
    this.radius = rad;
    this.dropped = false;
  }
  
  void drawDrop(PGraphics g){
    if(!this.dropped){
      //line part
      for(int i = 0; i < N_PARTICLES; i++){
        float dist = PVector.dist(this.rootPos, this.position) / (float)N_PARTICLES;
        PVector p = PVector.add(this.rootPos, new PVector(0, dist * i));
        
        g.ellipse(p.x, p.y, this.radius / 2.2, this.radius / 2.2);
      }
    }else{
      float dist = 20.0;
      
      //falling part
      for(int i = 0; i < 3; i++){
        PVector p = PVector.add(this.position, new PVector(0, dist * -i));
        
        g.ellipse(p.x, p.y, this.radius / 2.0, this.radius / 2.0);
      }
      
      //rising part
      for(int i = 0; i < 5; i++){
        PVector p = PVector.add(this.rootPos, new PVector(0, dist * i));
        
        g.ellipse(p.x, p.y, this.radius / 1.2, this.radius / 1.2);
      }
    }
    
    //main part
    g.ellipse(position.x, position.y, radius, radius);
  }
  
  void updateDrop(){
    if(!this.dropped){
      this.position.y += speed;
    }else{
      this.position.y += 30;
      this.rootPos.y -= 1.3;
    }
    
    if(PVector.dist(this.rootPos, this.position) > DROP_DIST) dropped = true;
  }
}
