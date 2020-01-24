// PGraphicsでPImageとして描画したものにフィルターをかける
// 標準のぼかしフィルタがえげつない重さなので自前でシェーダー用意
// 2値化処理も少し拡張したものを使用する
PGraphics pg;
PShader blur;
PShader thresh;

//gui variable
int renderType = 0;
float blurWidth = .25;
int blurPass = 5;
float threshold = 0;
float wid = .1;
float lod = 0;

//shape color
float[] shapeCol = {80, 45, 15}; // rgb
//shape alpha
float alpha = 50;

//dropのリスト
ArrayList<Drop> drops;

//波描画用
float theta = 0;

void setup(){
  // canvas init
  // shader使うのでP2Dレンダラー
  size(600, 600, P2D);
  frameRate(60);
  
  //PGraphics init
  pg = createGraphics(width, height, P2D);

  drops = new ArrayList<Drop>();
  
  //shader init
  blur = loadShader("blur.glsl");
  blur.set("resolution", (float)width, (float)height);
  blur.set("width", blurWidth);
  
  thresh = loadShader("threshold.glsl");
  thresh.set("resolution", (float)width, (float)height);
  thresh.set("threshold", threshold);
  thresh.set("wid", wid);
  thresh.set("fillColor", shapeCol[0]/255, shapeCol[1]/255, shapeCol[2]/255);

  initGUI();
}

void draw(){
  //---draw shape part---//
  pg.beginDraw();
  
  //renderer setting
  pg.noStroke();
  pg.smooth();
  pg.background(0);
  pg.fill(255, alpha);
  
  //draw wave at the top
  int waves = 15;
  float waveCenter = 25;
  float waveX = width / (float)(waves - 1);
  float waveRad = 100;
  for(int i = 0; i < waves; i++){
    float waveY = waveCenter + sin(theta*2 + i*3.5)*4 + sin(theta + i*.45)*10 + sin(theta*1.4 + i*1.8)*5;
    pg.ellipse(waveX * i, waveY, waveRad, waveRad);
  }
  theta += .015;
  
  //drops process
  for(int i = drops.size() - 1; i >= 0; i--){
    Drop drop = drops.get(i);
    drop.updateDrop();
    if(drop.rootPos.y < -100){
       drops.remove(i); 
    }else{
      drop.drawDrop(pg);
    }
  }
  
  pg.endDraw();
  //---end draw shape part---//

  //---shader part---//
  //update shader uniform
  blur.set("width", blurWidth);
  thresh.set("threshold", threshold);
  thresh.set("wid", wid);
  
  //apply fIlter to pg
  blurFilter(pg);
  thresholdFilter(pg);
  //---end shader part---//
  
  //draw to canvas
  image(pg, 0, 0);
}


//---Filters---//
void blurFilter(PGraphics g){
  if(renderType != 1){
    for(int i = 0; i < blurPass; i++) {
      pg.beginDraw();
      blur.set("pg", g);
      pg.shader(blur);
      pg.rect(0, 0, width, height);
      pg.resetShader();
      pg.endDraw();
    }
  }
}

void thresholdFilter(PGraphics g){
  if(renderType == 0){
    pg.beginDraw();
    thresh.set("pg", g);
    pg.shader(thresh);
    pg.rect(0, 0, width, height);
    pg.resetShader();
    pg.endDraw();
  }
}
//---end Filters---//

void mousePressed(){
  println("X : " + mouseX);
  drops.add(new Drop(new PVector(mouseX, 15), random(50) + 25));
}
