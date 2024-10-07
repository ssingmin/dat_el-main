

//Rent MyTrakSlotTransTyoe from Back
MyTrakSlotTransType* rentRoutedAbsFc();

//Rent and Attach MyTrakSerializeType from Back
MyTrakSlotTransType* attachRoutedAbsFc(MyTrakSlotTransType** rootSlotMove);

//Return MyTrakSlotTransTyoe from Back
void rtnRoutedAbsFc(MyTrakSlotTransType* rtnFc);

//Rent MyTrakSerializeType from Back
MyTrakSerializeType* rentRoutedVelFc();

//Rent and Attach MyTrakSerializeType from Back
MyTrakSerializeType* attachRoutedVelFc(MyTrakSerializeType** rootSerialize);

//Return MyTrakSerializeType to Back
void rtnRoutedVelFc(MyTrakSerializeType* rtnFc);

//Search Next slot of stage
int SearchNextSlot(UDINT firstSlot, int currentSlot, unsigned int slotCount);

//Realease list of MyTrakSlotTransType
void releaseMyTrakSlotTran(MyTrakSlotTransType** executeList);

//Realease list of MyTrakSerializeType
void releaseMyTrakSerialize(MyTrakSerializeType** executeList);

//execute list of MyTrakSlotTransType
DINT execMyTrakSlotTrans(MyTrakSlotTransType** executeList);

//execute list of MyTrakSerializeType
DINT execMyTrakSerialize(MyTrakSerializeType** executeList);
