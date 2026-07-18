// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pharmacy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Pharmacy {

 int get id; String get name; String get phone; String get address; String get district; double get latitude; double get longitude; bool get isOnDuty; String? get openingTime; String? get closingTime;
/// Create a copy of Pharmacy
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PharmacyCopyWith<Pharmacy> get copyWith => _$PharmacyCopyWithImpl<Pharmacy>(this as Pharmacy, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pharmacy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isOnDuty, isOnDuty) || other.isOnDuty == isOnDuty)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,address,district,latitude,longitude,isOnDuty,openingTime,closingTime);

@override
String toString() {
  return 'Pharmacy(id: $id, name: $name, phone: $phone, address: $address, district: $district, latitude: $latitude, longitude: $longitude, isOnDuty: $isOnDuty, openingTime: $openingTime, closingTime: $closingTime)';
}


}

/// @nodoc
abstract mixin class $PharmacyCopyWith<$Res>  {
  factory $PharmacyCopyWith(Pharmacy value, $Res Function(Pharmacy) _then) = _$PharmacyCopyWithImpl;
@useResult
$Res call({
 int id, String name, String phone, String address, String district, double latitude, double longitude, bool isOnDuty, String? openingTime, String? closingTime
});




}
/// @nodoc
class _$PharmacyCopyWithImpl<$Res>
    implements $PharmacyCopyWith<$Res> {
  _$PharmacyCopyWithImpl(this._self, this._then);

  final Pharmacy _self;
  final $Res Function(Pharmacy) _then;

/// Create a copy of Pharmacy
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


/// Adds pattern-matching-related methods to [Pharmacy].
extension PharmacyPatterns on Pharmacy {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pharmacy value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pharmacy() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pharmacy value)  $default,){
final _that = this;
switch (_that) {
case _Pharmacy():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pharmacy value)?  $default,){
final _that = this;
switch (_that) {
case _Pharmacy() when $default != null:
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
case _Pharmacy() when $default != null:
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
case _Pharmacy():
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
case _Pharmacy() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.address,_that.district,_that.latitude,_that.longitude,_that.isOnDuty,_that.openingTime,_that.closingTime);case _:
  return null;

}
}

}

/// @nodoc


class _Pharmacy extends Pharmacy {
  const _Pharmacy({required this.id, required this.name, required this.phone, required this.address, required this.district, required this.latitude, required this.longitude, required this.isOnDuty, this.openingTime, this.closingTime}): super._();
  

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

/// Create a copy of Pharmacy
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PharmacyCopyWith<_Pharmacy> get copyWith => __$PharmacyCopyWithImpl<_Pharmacy>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pharmacy&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.district, district) || other.district == district)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isOnDuty, isOnDuty) || other.isOnDuty == isOnDuty)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,address,district,latitude,longitude,isOnDuty,openingTime,closingTime);

@override
String toString() {
  return 'Pharmacy(id: $id, name: $name, phone: $phone, address: $address, district: $district, latitude: $latitude, longitude: $longitude, isOnDuty: $isOnDuty, openingTime: $openingTime, closingTime: $closingTime)';
}


}

/// @nodoc
abstract mixin class _$PharmacyCopyWith<$Res> implements $PharmacyCopyWith<$Res> {
  factory _$PharmacyCopyWith(_Pharmacy value, $Res Function(_Pharmacy) _then) = __$PharmacyCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String phone, String address, String district, double latitude, double longitude, bool isOnDuty, String? openingTime, String? closingTime
});




}
/// @nodoc
class __$PharmacyCopyWithImpl<$Res>
    implements _$PharmacyCopyWith<$Res> {
  __$PharmacyCopyWithImpl(this._self, this._then);

  final _Pharmacy _self;
  final $Res Function(_Pharmacy) _then;

/// Create a copy of Pharmacy
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? address = null,Object? district = null,Object? latitude = null,Object? longitude = null,Object? isOnDuty = null,Object? openingTime = freezed,Object? closingTime = freezed,}) {
  return _then(_Pharmacy(
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
