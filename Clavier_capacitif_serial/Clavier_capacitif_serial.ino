#include <CapacitiveSensor.h>

/*
 * CapitiveSense Library Demo Sketch
 * Paul Badger 2008
 * Uses a high value resistor e.g. 10M between send pin and receive pin
 * Resistor effects sensitivity, experiment with values, 50K - 50M. Larger resistor values yield larger sensor values.
 * Receive pin is the sensor pin - try different amounts of foil/metal on this pin
 */

//déclare des variables qui seront utilisées pour la communication serial
int A = 0;    
int B = 0;   
int C = 0;    
int D = 0;    
int E = 0;   
int F = 0;    


 const byte PIN_BUZZER = 3; //déclare le pin 3 comme associé à un haut parleur

// déclare les touches comme des capteurs capacitifs
CapacitiveSensor   cs_4_11 = CapacitiveSensor(4,11); 
CapacitiveSensor   cs_4_10 = CapacitiveSensor(4,10); 
CapacitiveSensor   cs_4_9 = CapacitiveSensor(4,9); 
CapacitiveSensor   cs_4_8 = CapacitiveSensor(4,8);        
CapacitiveSensor   cs_4_7 = CapacitiveSensor(4,7);        
CapacitiveSensor   cs_4_6 = CapacitiveSensor(4,6);        

void setup()                    
{
   Serial.begin(9600);

   pinMode(PIN_BUZZER, OUTPUT);

  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  pinMode(2, INPUT);   // digital sensor is on digital pin 2
 // establishContact();  // send a byte to establish contact until receiver responds
   
}

void loop()                    
{
    long start = millis();
    // mesures capacitive de chaque touche
    long total6 =  cs_4_11.capacitiveSensor(30);
    long total5 =  cs_4_10.capacitiveSensor(30);
    long total4 =  cs_4_9.capacitiveSensor(30);
    long total3 =  cs_4_8.capacitiveSensor(30);
    long total2 =  cs_4_7.capacitiveSensor(30);
    long total1 =  cs_4_6.capacitiveSensor(30);

    Serial.print(millis() - start); // affiche le délais entre le début de la boucle et la fin des mesures capacitives
    Serial.print("\t");                    
    
       // affiche les valeurs de capacité au niveau de chaque touche
    Serial.print(total1);                 
    Serial.print("\t");
    Serial.print(total2);                  
    Serial.print("\t");
    Serial.print(total3);                
    Serial.print("\t");
    Serial.print(total4); 
    Serial.print("\t");
    Serial.print(total5); 
    Serial.print("\t");
    Serial.println(total6); 
    Serial.print("\t");
 
noTone(3);

    if (total1<70) { // lors d'un pression sur une touche, exécute lesactiuons suivantes
      analogWrite(A0,255); // allume une LED branché à A0
      tone(PIN_BUZZER, 440); // émet un son à 440 hz sur le haut parleur
      F = 1; }               // la variable F prend la valeur 1
    else {
      analogWrite(A0,0);
      F = 0;
      }

    if (total2<70) {
      analogWrite(A1,255);
      tone(PIN_BUZZER, 392);
      E = 1; }
    else {
      analogWrite(A1,0); 
      E = 0; }

    if (total3<70) {
      analogWrite(A2,255);
      tone(PIN_BUZZER, 349);
      D = 1; }
    else {
      analogWrite(A2,0);
      D = 0; }
      
     if (total4<70) {
      analogWrite(A3,255);
      tone(PIN_BUZZER, 329);
      C = 1; }
    else {
      analogWrite(A3,0); 
      C = 0; }
      
     if (total5<70) {
      analogWrite(A4,255);
      tone(PIN_BUZZER, 293);
      B = 1;}
    else {
      analogWrite(A4,0);
      B= 0;}
      
     if (total6<70) {
      analogWrite(A5,255);
      tone(PIN_BUZZER, 261);
      A = 1;}
    else {
      analogWrite(A5,0);
      A = 0;}

      
if (Serial.available() > 0) { //lorsque processing est connecté en serial 
   Serial.write(A);           //envoie les lettres suivante lors d'une pression sur une touche
   Serial.write(B);
   Serial.write(C);
   Serial.write(D);
   Serial.write(E);
   Serial.write(F);

    delay(10);                             // arbitrary delay to limit data to serial port 
  }
    
}

void establishContact() { //connexion avec processing
  while (Serial.available() <= 0) {
    Serial.print('A');   // send a capital A
    delay(300);
  }
} 
