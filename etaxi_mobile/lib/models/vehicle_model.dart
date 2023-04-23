class VehicleModel {
  int? vehicleId;
  int? modelId;
  int? typeId;
  String? photo;
  String? vehicleName;
  int? price;
  String? seater;
  String? fuelType;
  String? transmission;
  int? year;
  bool? airBags;
  String? isLimited;
  String? isUnlimited;

  VehicleModel(
      {this.vehicleId,
      this.modelId,
      this.typeId,
      this.photo,
      this.vehicleName,
      this.price,
      this.seater,
      this.fuelType,
      this.transmission,
      this.year,
      this.airBags,
      this.isLimited,
      this.isUnlimited});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleId = json['VehicleId'] ?? 0;
    modelId = json['model_id'] ?? -1;
    typeId = json['TypeId'] ?? 0;
    photo = json['File'] ?? '';
    vehicleName = json['Name'] ?? 'Bob the builder';
    price = json['PricePerKm'] ?? '100';
    seater = json['seater'] ?? '5';
    fuelType = json['FuelType'] ?? 'Benzinjara';
    transmission = json['Transmission'] ?? 'Manuelac';
    year = json['Year'] ?? 1998;
    airBags = json['AirBag'] ?? false;
    isLimited = json['is_limited'] ?? '';
    isUnlimited = json['is_unlimited'] ?? '';
  }
}
