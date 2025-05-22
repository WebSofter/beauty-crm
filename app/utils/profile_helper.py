
from profile.models import ClientProfile, WorkerProfile


def get_profile(rquest_user):
    # Определяем тип профиля пользователя (работник или клиент)
    profile = None
    profile_type = 'admin'
    
    # Сначала проверяем, является ли пользователь клиентом
    try:
        profile = ClientProfile.objects.get(user=rquest_user)
        profile_type = 'client'
    except ClientProfile.DoesNotExist:
        # Если не клиент, проверяем, является ли работником
        try:
            profile = WorkerProfile.objects.get(user=rquest_user)
            profile_type = 'worker'
        except WorkerProfile.DoesNotExist:
            # Пользователь не имеет ни одного профиля
            pass
    
    return (profile, profile_type)