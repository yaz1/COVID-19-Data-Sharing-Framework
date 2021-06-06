package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type SmartContract struct {
	contractapi.Contract
}

type Record struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

// QueryResult structure used for handling result of query
type QueryResult struct {
	Key string `json:"Key"`
	Rec *Record
}



func (s *SmartContract) SetRecord2(ctx contractapi.TransactionContextInterface, key string, value string) error {
	rec := Record{
		Key:   key,
		Value: value,
	}


	recAsBytes, _ := json.Marshal(rec)

	return ctx.GetStub().PutPrivateData("_implicit_org_Org1MSP", key, recAsBytes)

	
}

func (s *SmartContract) GetRecord(ctx contractapi.TransactionContextInterface, key string) (*Record, error) {

	recAsBytes, err := ctx.GetStub().GetPrivateData("_implicit_org_Org1MSP", key)


	if err != nil {
		return nil, fmt.Errorf("Failed to read from world state. %s", err.Error())
	}

	if recAsBytes == nil {
		return nil, fmt.Errorf("%s does not exist", key)
	}

	rec := new(Record)
	_ = json.Unmarshal(recAsBytes, rec)

	return rec, nil
}



func main() {

	chaincode, err := contractapi.NewChaincode(new(SmartContract))

	if err != nil {
		fmt.Printf("Error create  chaincode: %s", err.Error())
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting  chaincode: %s", err.Error())
	}
}






func (s *SmartContract) SetRecord(ctx contractapi.TransactionContextInterface, key string, value string) error {

	type keyValueTransientInput struct {
		Key   string `json:"key"`
		Value string `json:"value"`
	}

	

	transMap, err := ctx.GetStub().GetTransient()
	if err != nil {
		return fmt.Errorf("Failed to get transient")
	}

	// assuming only "name" is processed
	keyValueAsBytes, ok := transMap["keyvalue"]
	if !ok {
		return fmt.Errorf("key must be keyvalue")
	}

	var keyValueInput keyValueTransientInput
	err = json.Unmarshal(keyValueAsBytes, &keyValueInput)
	if err != nil {
		return fmt.Errorf("Failed to decode JSON")
	}

	return ctx.GetStub().PutPrivateData("_implicit_org_Org1MSP", keyValueInput.Key, []byte(keyValueInput.Value))

}

