import 'package:common/features/member_pal_login/data/data_sources/member_pal_login_remote_data_source.dart';
import 'package:common/features/member_pal_login/data/dtos/member_pal_login_response_dto.dart';
import 'package:common/features/member_pal_login/domain/entities/member_pal_login_request_entity.dart';
import 'package:common/features/member_pal_login/domain/entities/send_otp_request_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_pal_login_repo.g.dart';

@riverpod
MemberPalLoginRepo memberPalLoginRepo(MemberPalLoginRepoRef ref) {
  return MemberPalLoginRepo(
    memberPalLoginRemoteDataSource:
        ref.watch(memberPalLoginRemoteDataSourceProvider),
  );
}

class MemberPalLoginRepo {
  final MemberPalLoginRemoteDataSource memberPalLoginRemoteDataSource;

  MemberPalLoginRepo({required this.memberPalLoginRemoteDataSource});

  Future<MemberPalLoginResponseDto> memberPalLoginRegister(
      {required MemberPalLoginRequestEntity requestEntity}) async {
    return await memberPalLoginRemoteDataSource.memberPalLoginRegister(
        requestEntity: requestEntity);
  }

  Future<bool> memberPalSendOtp(
      {required SendOtpRequestEntity sendOtpEntity}) async {
    return await memberPalLoginRemoteDataSource.memberPalSendOtp(
        sendOtpEntity: sendOtpEntity);
  }
}
