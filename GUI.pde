import controlP5.*;

ControlP5 cp5;
RadioButton typeSwitcher;

void initGUI(){
 //gui
  cp5 = new ControlP5(this);
  
  //---Shader GUIs---//
  cp5.addSlider("blurWidthSlider")
    .setPosition(10, 140)
    .setSize(100, 15)
    .setRange(0, .5)
    .setValue(.25);
    
  cp5.addSlider("blurPassSlider")
    .setPosition(10, 185)
    .setSize(100, 15)
    .setRange(1, 10)
    .setValue(4);
    
  cp5.getController("blurWidthSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("blurPassSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  
    
  cp5.addSlider("thresholdSlider")
    .setPosition(10, 250)
    .setSize(100, 15)
    .setRange(0, 1)
    .setColorBackground(color(40, 5, 5))
    .setColorActive(color(220, 40, 40))
    .setColorForeground(color(160, 10, 10))
    .setValue(.25);
    
  cp5.addSlider("threshWidSlider")
    .setPosition(10, 295)
    .setSize(100, 15)
    .setRange(0, .1)
    .setColorBackground(color(40, 5, 5))
    .setColorActive(color(220, 40, 40))
    .setColorForeground(color(160, 10, 10))
    .setValue(.015);
  
  cp5.getController("thresholdSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("threshWidSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  //---end shader GUIs---//
  
  //Render switch
  typeSwitcher = cp5.addRadioButton("switchRenderType")
   .setPosition(10, 20)
   .setItemWidth(20)
   .setItemHeight(20)
   .setSpacingRow(10)
   .setColorBackground(color(40))
   .setColorActive(color(240))
   .setColorForeground(color(160))
   .addItem("Render", 0)
   .addItem("Circle", 1)
   .addItem("Blurred", 2)
   .setColorLabel(color(255))
   .activate(0);
   
   //fps watcher
   cp5.addFrameRate().setInterval(10).setPosition(0,height - 10);
}


//---gui操作で呼ばれるコールバック---//
void blurWidthSlider(float value){
  println(value); 
  blurWidth = value;
}

void blurPassSlider(int value){
  println(value); 
  blurPass = value;
}

void thresholdSlider(float value){
  println(value); 
  threshold = value;
}

void threshWidSlider(float value){
  println(value); 
  wid = value;
}

void switchRenderType(int value){
  println(value); 
  
  //-1が入ってきたとき用のセーフティ込み
  if(value >= 0)
    renderType = value;
  typeSwitcher.activate(renderType);
}
//---end callback---//
