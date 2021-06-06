/*
SPDX-License-Identifier: Apache-2.0
*/

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



func (s *SmartContract) SetRecord(ctx contractapi.TransactionContextInterface, key string, value string) error {
	rec := Record{
		Key:   key,
		Value: value,
	}
	clientID, err := ctx.GetClientIdentity().GetMSPID()
	if err != nil {
		return fmt.Errorf("failed to get client id: %v", err)
	}
	if clientID != "Org1MSP"{
		return fmt.Errorf("Unauthorized %s", clientID )

	}

	recAsBytes, _ := json.Marshal(rec)

	return ctx.GetStub().PutState(key, recAsBytes)
}

func (s *SmartContract) GetRecord(ctx contractapi.TransactionContextInterface, key string) (*Record, error) {
	recAsBytes, err := ctx.GetStub().GetState(key)

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

func (s *SmartContract) GetAll(ctx contractapi.TransactionContextInterface) ([]QueryResult, error) {
	startKey := ""
	endKey := ""

	resultsIterator, err := ctx.GetStub().GetStateByRange(startKey, endKey)

	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	results := []QueryResult{}

	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()

		if err != nil {
			return nil, err
		}

		rec := new(Record)
		_ = json.Unmarshal(queryResponse.Value, rec)

		queryResult := QueryResult{Key: queryResponse.Key, Rec: rec}
		results = append(results, queryResult)
	}

	return results, nil
}

func main() {

	chaincode, err := contractapi.NewChaincode(new(SmartContract))

	if err != nil {
		fmt.Printf("Error create chaincode: %s", err.Error())
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting  chaincode: %s", err.Error())
	}
}
