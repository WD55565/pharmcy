// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pharmacy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PharmacyModel {

 int get id; String get name; String get phone; String get address; String get district; double get latitude; double get longitude; bool get isOnDuty; String? get openingTime; String? get closingTime;
/// Create a copy of PharmacyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PharmacyModelCopyWith<PharmacyModel> get copyWith => _$PharmacyModelCopyWithImpl<PharmacyModel>(this as PharmacyModel, _$identity);

  /// Serializes this PharmacyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PharmacyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isOnDuty, isOnDuty) || other.isOnDuty == isOnDuty)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,address,district,latitude,longitude,isOnDuty,openingTime,closingTime);

@override
String toString() {
  return 'PharmacyModel(id: $id, name: $name, phone: $phone, address: $address, district: $district, latitude: $latitude, longitude: $longitude, isOnDuty: $isOnDuty, openingTime: $openingTime, closingTime: $closingTime)';
}


}

/// @nodoc
abstract mixin class $PharmacyModelCopyWith<$Res>  {
  factory $PharmacyModelCopyWith(PharmacyModel value, $Res Function(PharmacyModel) _then) = _$PharmacyModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone, String address, String district, double latitude, double longitude, bool isOnDuty, String? openingTime, String? closingTime
});




}
/// @nodoc
class _$PharmacyModelCopyWithImpl<$Res>
    implements $PharmacyModelCopyWith<$Res> {
  _$PharmacyModelCopyWithImpl(this._self, this._then);

  final PharmacyModel _self;
  final $Res Function(PharmacyModel) _then;

/// Create a copy of PharmacyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? address = null,Object? district = null,Object? latitude = null,Object? longitude = null,Object? isOnDuty = null,Object? openingTime = freezed,Object? closingTime = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isOnDuty: null == isOnDuty ? _self.isOnDuty : isOnDuty // ignore: cast_nullable_to_non_nullable
as bool,openingTime: freezed == openingTime ? _self.openingTime : openingTime // ignore: cast_nullable_to_non_nullable
as String?,closingTime: freezed == closingTime ? _self.closingTime : closingTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PharmacyModel].
extension PharmacyModelPatterns on PharmacyModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PharmacyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PharmacyModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PharmacyModel value)  $default,){
final _that = this;
switch (_that) {
case _PharmacyModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PharmacyModel value)?  $default,){
final _that = this;
switch (_that) {
case _PharmacyModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String address,  String district,  double latitude,  double longitude,  bool isOnDuty,  String? openingTime,  String? closingTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PharmacyModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.address,_that.district,_that.latitude,_that.longitude,_that.isOnDuty,_that.openingTime,_that.closingTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String phone,  String address,  String district,  double latitude,  double longitude,  bool isOnDuty,  String? openingTime,  String? closingTime)  $default,) {final _that = this;
switch (_that) {
case _PharmacyModel():
return $default(_that.id,_that.name,_that.phone,_that.address,_that.district,_that.latitude,_that.longitude,_that.isOnDuty,_that.openingTime,_that.closingTime);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String phone,  String address,  String district,  double latitude,  double longitude,  bool isOnDuty,  String? openingTime,  String? closingTime)?  $default,) {final _that = this;
switch (_that) {
case _PharmacyModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.address,_that.district,_that.latitude,_that.longitude,_that.isOnDuty,_that.openingTime,_that.closingTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PharmacyModel extends PharmacyModel {
  const _PharmacyModel({required this.id, required this.name, required this.phone, required this.address, required this.district, required this.latitude, required this.longitude, required this.isOnDuty, this.openingTime, this.closingTime}): super._();
  factory _PharmacyModel.fromJson(Map<String, dynamic> json) => _$PharmacyModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String phone;
@override final  String address;
@override final  String district;
@override final  double latitude;
@override final  double longitude;
@override final  bool isOnDuty;
@override final  String? openingTime;
@override final  String? closingTime;

/// Create a copy of PharmacyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PharmacyModelCopyWith<_PharmacyModel> get copyWith => __$PharmacyModelCopyWithImpl<_PharmacyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PharmacyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PharmacyModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isOnDuty, isOnDuty) || other.isOnDuty == isOnDuty)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,phone,address,district,latitude,longitude,isOnDuty,openingTime,closingTime);

@override
String toString() {
  return 'PharmacyModel(id: $id, name: $name, phone: $phone, address: $address, district: $district, latitude: $latitude, longitude: $longitude, isOnDuty: $isOnDuty, openingTime: $openingTime, closingTime: $closingTime)';
}


}

/// @nodoc
abstract mixin class _$PharmacyModelCopyWith<$Res> implements $PharmacyModelCopyWith<$Res> {
  factory _$PharmacyModelCopyWith(_PharmacyModel value, $Res Function(_PharmacyModel) _then) = __$PharmacyModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone, String address, String district, double latitude, double longitude, bool isOnDuty, String? openingTime, String? closingTime
});




}
/// @nodoc
class __$PharmacyModelCopyWithImpl<$Res>
    implements _$PharmacyModelCopyWith<$Res> {
  __$PharmacyModelCopyWithImpl(this._self, this._then);

  final _PharmacyModel _self;
  final $Res Function(_PharmacyModel) _then;

/// Create a copy of PharmacyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? address = null,Object? district = null,Object? latitude = null,Object? longitude = null,Object? isOnDuty = null,Object? openingTime = freezed,Object? closingTime = freezed,}) {
  return _then(_PharmacyModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,isOnDuty: null == isOnDuty ? _self.isOnDuty : isOnDuty // ignore: cast_nullable_to_non_nullable
as bool,openingTime: freezed == openingTime ? _self.openingTime : openingTime // ignore: cast_nullable_to_non_nullable
as String?,closingTime: freezed == closingTime ? _self.closingTime : closingTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
