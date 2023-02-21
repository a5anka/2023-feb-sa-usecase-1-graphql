import ballerina/graphql;

public type ItemEntry record {|
    readonly string itemCode;
    string displaceName;
    string description;
    string includes;
    string intendeFor;
    string color;
    string material;
    decimal price;
|};

table<ItemEntry> key(itemCode) itemEntriesTable = table [
    {itemCode: "1", displaceName: "Item 1", description: "Item 1 Description", includes: "Item 1 Includes", intendeFor: "Item 1 Intended For", color: "Item 1 Color", material: "Item 1 Material", price: 100},
    {itemCode: "2", displaceName: "Item 2", description: "Item 2 Description", includes: "Item 2 Includes", intendeFor: "Item 2 Intended For", color: "Item 2 Color", material: "Item 2 Material", price: 200},
    {itemCode: "3", displaceName: "Item 3", description: "Item 3 Description", includes: "Item 3 Includes", intendeFor: "Item 3 Intended For", color: "Item 3 Color", material: "Item 3 Material", price: 300}
];

service /graphql on new graphql:Listener(9000) {
    resource function get all() returns ItemData[] {
        ItemEntry[] itemEntries = itemEntriesTable.toArray().cloneReadOnly();
        return itemEntries.map(entry => new ItemData(entry));
    }
}

public distinct service class ItemData {
    private final readonly & ItemEntry entryRecord;

    function init(ItemEntry entryRecord) {
        self.entryRecord = entryRecord.cloneReadOnly();
    }

    resource function get itemCode() returns string {
        return self.entryRecord.itemCode;
    }

    resource function get displayName() returns string {
        return self.entryRecord.displaceName;
    }

    resource function get includes() returns string {
        return self.entryRecord.includes;
    }

    resource function get intendedFor() returns string {
        return self.entryRecord.intendeFor;
    }

    resource function get color() returns string {
        return self.entryRecord.color;
    }

    resource function get material() returns string {
        return self.entryRecord.material;
    }

    resource function get price() returns decimal? {
        return self.entryRecord.price;
    }
}
