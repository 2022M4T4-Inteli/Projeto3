// #include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include <MFRC522.h>
#include <SPI.h>

#define RFID_SS_SDA   21
#define RFID_RST      14

#define ledb  2
#define led_verde     5
#define buzzer        40
int iniciar = 0;

MFRC522 rfidBase = MFRC522(RFID_SS_SDA, RFID_RST);
class LeitorRFID{
  private:
    char codigoRFIDLido[100] = "";
    char codigoRFIDEsperado[100] = "";
    MFRC522 *rfid = NULL;
    int cartaoDetectado = 0;
    int cartaoJaLido = 0;
    void processaCodigoLido(){
      char codigo[3*rfid->uid.size+1];
      codigo[0] = 0;
      char temp[10];
      for(int i=0; i < rfid->uid.size; i++){
        sprintf(temp,"%X",rfid->uid.uidByte[i]);
        strcat(codigo,temp);
      }
      codigo[3*rfid->uid.size+1] = 0;
      strcpy(codigoRFIDLido,codigo);
      Serial.println(codigoRFIDLido);
    }
  public:
    LeitorRFID(MFRC522 *leitor){
      rfid = leitor;
      rfid->PCD_Init();
      Serial.printf("MOSI: %i MISO: %i SCK: %i SS: %i\n",MOSI,MISO,SCK,SS);
    };
    char *tipoCartao(){
      MFRC522::PICC_Type piccType = rfid->PICC_GetType(rfid->uid.sak);
      Serial.println(rfid->PICC_GetTypeName(piccType));
      return((char *)rfid->PICC_GetTypeName(piccType));
    };
    int cartaoPresente(){
      return(cartaoDetectado);
    };
    int cartaoFoiLido(){
      return(cartaoJaLido);
    };
    void leCartao(){
      if (rfid->PICC_IsNewCardPresent()) { // new tag is available
        iniciar = 7;
        Serial.println("Cartao presente"); //Será printado no console
          while (iniciar != 0){
            digitalWrite(led_verde, HIGH);
            delay(80);
            digitalWrite(led_verde, LOW);
            delay(80);
            iniciar -= 1;
          }
        cartaoDetectado = 1;
        if (rfid->PICC_ReadCardSerial()) { // NUID has been readed
          Serial.println("Cartao lido"); //Será printado no console
          digitalWrite(led_verde, HIGH);
          cartaoJaLido = 1;
          processaCodigoLido();
          rfid->PICC_HaltA(); // halt PICC
          rfid->PCD_StopCrypto1(); // stop encryption on PCD
          tone(buzzer, 3000, 1000);
          delay(1000);
        }
      }else{
        cartaoDetectado = 0;
        iniciar = 10;
        digitalWrite(led_verde, LOW);
      }
    };
    char *cartaoLido(){
      return(codigoRFIDLido);
    };
    void resetarLeitura(){
      cartaoDetectado = 0;
      cartaoJaLido = 0;
      iniciar = 10;
    }
    void listI2CPorts(){
      Serial.println("\nI2C Scanner");
      byte error, address;
      int nDevices;
      Serial.println("Scanning...");
      nDevices = 0;
      for(address = 1; address < 127; address++ ) {
        Wire.beginTransmission(address);
        error = Wire.endTransmission();
        if (error == 0) {
          Serial.print("I2C device found at address 0x");
          if (address<16) {
            Serial.print("0");
          }
          Serial.println(address,HEX);
          nDevices++;
        }
        else if (error==4) {
          Serial.print("Unknow error at address 0x");
          if (address<16) {
            Serial.print("0");
          }
          Serial.println(address,HEX);
        }
      }
      if (nDevices == 0) {
        Serial.println("No I2C devices found\n");
      }
      else {
        Serial.println("done\n");
      }
    };
};
LeitorRFID *leitor = NULL;
//////////////////////////////
void setup() {
  Serial.begin(115200);
  SPI.begin();
  pinMode(ledb, OUTPUT);
  pinMode(led_verde, OUTPUT);
  pinMode(buzzer, OUTPUT);
  digitalWrite(ledb, HIGH);
  //------------------------//
  leitor = new LeitorRFID(&rfidBase);
  //------------------------//

  // Serial.print("MOSI: "); Serial.println(MOSI);
  // Serial.print("MISO: "); Serial.println(MISO);
  // Serial.print("SCK: "); Serial.println(SCK);
  // Serial.print("SS: "); Serial.println(SS);
}
void loop() {
  Serial.println("Lendo Cartao:");
  leitor->leCartao();
  if(leitor->cartaoFoiLido()){
    Serial.println(leitor->tipoCartao());
    Serial.println(leitor->cartaoLido());
    leitor->resetarLeitura();
    delay(8000);
  }
}