### Pseudo-polar for our full authorization rules using imaginary data types ###
# Typical 'Medical data' points (Immunization, MedicationStatement etc)
# allow(actor: Actor, operation: String, resource: Resource) if
#     access_frozen_check(actor, resource) and (  
#         self_check(actor, immumization) or
#         source_check(actor, immunization) or
#         consent_check(actor, immunization));

# More complex Communication type
# allow(actor: Actor, operation: String, communication: Communication) if 
#     access_frozen_check(actor, communication) and 
#     private_communication_check(actor, communication) and 
#     draft_communication_check(actor, communication) and (  
#        self_check(actor, communication) or
#        source_check(actor, communication) or
#        consent_check(actor, communication) or 
#        communication_participant_check(actor, communication));

# self_check(actor: Actor, resource: Resource) if
#     actor.isPerson = true and  
#         resource.patient = person;

# source_check(actor: Actor, resource: Resource) if
#     actor.teams.contains(resource.sourceTeam) or 
#         (actor.isPerson = true and 
#             actor = resource.sourcePerson);

# consent_check(actor: Actor, resource: Resource, context: Context) if
#     sharing_disabled_check(actor, resource) and
#         (context.isBtgActive or
#             resource.patient.consentsFor(actor).contains(resource.privacyFlag) or 
#                 resource.patient.consentsFor(actor.teams).contains(resource.privacyFlag));

# sharing_disabled_check(actor: Actor, resource: Resource) if
#     # // TODO: MFA - system user semantics for sharing disabled?
#     not actor.isPerson or 
#         actor.isTeamPro or
#             resource.patient.sharingDisabled = false;

# access_frozen_check(actor: Actor, resource: Resource) if 
#     actor.isPerson = true and 
#         actor.accessFrozen = false and 
#             (actor.isTeamPro = true or 
#                 resource.patient.accessFrozen = false);
# 
# 
# private_communication_check(actor: Actor, communication: Communication) if
# # // TODO: MFA - Semantics of private conversations, can the team access?
# # what about system users? Current rules say no
#     not communication.private or 
#         communication.sender = actor 
#             or communication.recipients.contains(actor);
# 
# draft_communication_check(actor: Actor, communication: Communication) if 
#     not communication.draft or 
#         communication.sender = actor;
# 
# # // TODO: MFA - This is only necessary if it's possible to have someone as 
# # a participant when they don't have consent for the privacy flag of the 
# # conversation.
# communication_participant_check(actor: Actor, communication: Communication) if 
#     communication.participants.contains(actor);